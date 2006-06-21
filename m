Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWFUOoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWFUOoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWFUOoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:44:10 -0400
Received: from gw.openss7.com ([142.179.199.224]:38064 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932101AbWFUOoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:44:09 -0400
Date: Wed, 21 Jun 2006 08:44:08 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Theodore Tso <tytso@thunk.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Message-ID: <20060621084408.C7834@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Theodore Tso <tytso@thunk.org>,
	linux-kernel@vger.kernel.org
References: <20060621125146.508341000@candygram.thunk.org> <20060621125216.044675000@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060621125216.044675000@candygram.thunk.org>; from tytso@thunk.org on Wed, Jun 21, 2006 at 08:51:47AM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore,

On Wed, 21 Jun 2006, Theodore Tso wrote:
>  
>  static int remote_settings_file_open(struct inode *inode, struct file *file)
>  {
> -	file->private_data = inode->u.generic_ip;
> +	file->private_data = inode->i_private;
>  	return 0;
>  }
>  

I wish you would change private_data to f_private while your at it.
