Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263140AbTCLKhB>; Wed, 12 Mar 2003 05:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbTCLKhB>; Wed, 12 Mar 2003 05:37:01 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:28678 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263140AbTCLKhA>; Wed, 12 Mar 2003 05:37:00 -0500
Date: Wed, 12 Mar 2003 10:47:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Torsten Foertsch <torsten.foertsch@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.19] How to get the path name of a struct dentry
Message-ID: <20030312104741.A9625@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Torsten Foertsch <torsten.foertsch@gmx.net>,
	linux-kernel@vger.kernel.org
References: <200303121033.08560.torsten.foertsch@gmx.net> <20030312101133.A9312@infradead.org> <200303121138.31387.torsten.foertsch@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303121138.31387.torsten.foertsch@gmx.net>; from torsten.foertsch@gmx.net on Wed, Mar 12, 2003 at 11:38:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 11:38:27AM +0100, Torsten Foertsch wrote:
> Next question, is there a way to get the dentry and vfsmount of /? I mean not 
> current->fs->root and current->fs->rootmnt. They can be chrooted. I mean the 
> real /.

No.  Esecially as there is not single "real" root.
