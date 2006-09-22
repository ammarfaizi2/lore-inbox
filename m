Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWIVOmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWIVOmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWIVOmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:42:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30101 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932520AbWIVOmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:42:54 -0400
Date: Fri, 22 Sep 2006 15:42:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060922144233.GA25478@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060920135438.d7dd362b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> ecryptfs-fs-makefile-and-fs-kconfig.patch
> ecryptfs-fs-makefile-and-fs-kconfig-kconfig-help-update.patch
> ecryptfs-documentation.patch
> ecryptfs-makefile.patch
> ecryptfs-main-module-functions.patch
> ecryptfs-header-declarations.patch
> ecryptfs-superblock-operations.patch
> #ecryptfs-superblock-operations-ecryptfs-build-fix.patch
> ecryptfs-dentry-operations.patch
> ecryptfs-file-operations.patch
> #ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap.patch
> #ecryptfs-vs-streamline-generic_file_-interfaces-and-filemap-fix.patch
> ecryptfs-inode-operations.patch
> ecryptfs-mmap-operations.patch
> ecryptfs-mmap-operations-fix.patch
> ecryptfs-keystore.patch
> ecryptfs-crypto-functions.patch
> ecryptfs-crypto-functions-mutex-fixes.patch
> fs-ecryptfs-possible-cleanups.patch
> ecryptfs-debug-functions.patch
> ecryptfs-alpha-build-fix.patch
> ecryptfs-convert-assert-to-bug_on.patch
> ecryptfs-remove-pointless-bug_ons.patch
> ecryptfs-remove-unnecessary-null-checks.patch
> ecryptfs-rewrite-ecryptfs_fsync.patch
> ecryptfs-overhaul-file-locking.patch
> ecryptfs-remove-lock-propagation.patch
> ecryptfs-dont-muck-with-the-existing-nameidata-structures.patch
> ecryptfs-asm-scatterlisth-linux-scatterlisth.patch
> ecryptfs-support-for-larger-maximum-key-size.patch
> ecryptfs-add-codes-for-additional-ciphers.patch
> ecryptfs-unencrypted-key-size-based-on-encrypted-key-size.patch
> ecryptfs-packet-and-key-management-update-for-variable-key-size.patch
> ecryptfs-add-ecryptfs_-prefix-to-mount-options-key-size-parameter.patch
> ecryptfs-set-the-key-size-from-the-default-for-the-mount.patch
> ecryptfs-check-for-weak-keys.patch
> ecryptfs-add-define-values-for-cipher-codes-from-rfc2440-openpgp.patch
> ecryptfs-convert-bits-to-bytes.patch
> ecryptfs-more-elegant-aes-key-size-manipulation.patch
> ecryptfs-more-intelligent-use-of-tfm-objects.patch
> ecryptfs-remove-debugging-cruft.patch
> ecryptfs-get_sb_dev-fix.patch
> ecryptfs-validate-minimum-header-extent-size.patch
> ecryptfs-validate-body-size.patch
> ecryptfs-validate-packet-length-prior-to-parsing-add-comments.patch
> ecryptfs-use-the-passed-in-max-value-as-the-upper-bound.patch
> ecryptfs-change-the-maximum-size-check-when-writing-header.patch
> ecryptfs-print-the-actual-option-that-is-problematic.patch
> ecryptfs-add-a-maintainers-entry.patch
> ecryptfs-partial-signed-integer-to-size_t-conversion-updated-ii.patch
> ecryptfs-graceful-handling-of-mount-error.patch
> inode-diet-move-i_pipe-into-a-union-ecryptfs.patch
> inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-ecryptfs.patch
> streamline-generic_file_-interfaces-and-filemap-ecryptfs.patch
> ecryptfs-fix-printk-format-warnings.patch
> ecryptfs-associate-vfsmount-with-dentry-rather-than-superblock.patch
> ecryptfs-mntput-lower-mount-on-umount_begin.patch
> vfs-make-filldir_t-and-struct-kstat-deal-in-64-bit-inode-numbers-ecryptfs.patch
> make-kmem_cache_destroy-return-void-ecryptfs.patch
> ecryptfs-inode-numbering-fixes.patch
> ecryptfs-versioning-fixes.patch
> ecryptfs-versioning-fixes-tidy.patch
> 
>  Will fold into a single patch and will then merge.

Please add a

Not-Acked-By: Christoph Hellwig <hch@lst.de>

here as you don't seem to listen to any of the comments I had against
the current state and I want this clearly documented.
