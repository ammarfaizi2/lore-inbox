Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWFUPgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWFUPgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWFUPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:36:55 -0400
Received: from thunk.org ([69.25.196.29]:10209 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932185AbWFUPgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:36:54 -0400
Date: Wed, 21 Jun 2006 11:37:03 -0400
From: Theodore Tso <tytso@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Message-ID: <20060621153703.GA28159@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <20060621125146.508341000@candygram.thunk.org> <20060621125216.044675000@candygram.thunk.org> <20060621084408.C7834@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621084408.C7834@openss7.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 08:44:08AM -0600, Brian F. G. Bidulock wrote:
> Theodore,
> 
> On Wed, 21 Jun 2006, Theodore Tso wrote:
> >  
> >  static int remote_settings_file_open(struct inode *inode, struct file *file)
> >  {
> > -	file->private_data = inode->u.generic_ip;
> > +	file->private_data = inode->i_private;
> >  	return 0;
> >  }
> >  
> 
> I wish you would change private_data to f_private while your at it.

Different structure, different structure element, different patch.

							- Ted
