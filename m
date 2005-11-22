Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVKVHp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVKVHp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 02:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVKVHp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 02:45:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9876 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932368AbVKVHp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 02:45:57 -0500
Date: Tue, 22 Nov 2005 07:45:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122074553.GA20476@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
	Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
References: <E1EeLp5-0002fZ-00@calista.inka.de> <43825168.6050404@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43825168.6050404@wolfmountaingroup.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 03:59:52PM -0700, Jeff V. Merkey wrote:
> Linux is currently limited to 16 TB per VFS mount point, it's all mute, 
> unless VFS gets fixed.
> mmap won't go above this at present.

You're thinking of 32bit architectures.  There is no such limit for
64 bit architectures.  There are XFS volumes in the 100TB range in production
use.

