Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292214AbSBTTKi>; Wed, 20 Feb 2002 14:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292222AbSBTTK2>; Wed, 20 Feb 2002 14:10:28 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:36619 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292214AbSBTTKY>;
	Wed, 20 Feb 2002 14:10:24 -0500
Date: Wed, 20 Feb 2002 11:05:09 -0800
From: Greg KH <greg@kroah.com>
To: "J.P. Morris" <jpm@it-he.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rc2 problem..
Message-ID: <20020220190509.GA30784@kroah.com>
In-Reply-To: <20020220185855.2bcecc24.jpm@it-he.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020220185855.2bcecc24.jpm@it-he.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 23 Jan 2002 16:16:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 06:58:55PM +0000, J.P. Morris wrote:
> 
> I'm getting a problem in usb-storage (it's loaded as a module towards the end
> of the boot sequence).  The module locks during initialisation, which doesn't
> happen in 2.4.17.

Does the lockup happen without the CF reader plugged in?

If so, and you later plugin the CF reader (after the module is loaded)
does the kernel still lock up?

thanks,

greg k-h
