Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWCBLrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWCBLrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 06:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWCBLrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 06:47:53 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:31213 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932412AbWCBLrw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 06:47:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j1Qsj/p/zgNPCUCEeNMWn8OJDAnMi2sLlWHygglEK2ou0vAeX0ccgQWvlyTamPJra5DSjWjLj+Qw6sEPYMV/g9MujaMmYPBU8IX7K68HG4aTtEKqphfOuShQGYuA1E5JtHq8t1jnRDM3DsIp/ak9jSDfR33ajSAWo7WusPZlNpI=
Message-ID: <b6fcc0a0603020347r32567ae9l1fe4495059149449@mail.gmail.com>
Date: Thu, 2 Mar 2006 03:47:50 -0800
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: s_vfs_rename_sem and cifs (was Re: Possible deadlock in vfs layer, namei.c)
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 06:46:42PM -0800, Joshua Hudson wrote:
> from namei.c (function: lock_rename), rename takes:
> 1. s_vfs_rename_sem,

Speaking of s_vfs_rename_sem, does cifs usage of it despite explicit
warning at fs.h
was found to be legal?
