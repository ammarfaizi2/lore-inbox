Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268343AbTCCEyL>; Sun, 2 Mar 2003 23:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268348AbTCCEyL>; Sun, 2 Mar 2003 23:54:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:54799 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268343AbTCCEyK>;
	Sun, 2 Mar 2003 23:54:10 -0500
Date: Sun, 2 Mar 2003 20:55:25 -0800
From: Greg KH <greg@kroah.com>
To: mdew <mdew@mdew.dyndns.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Stv0680-usb-general] USB error?
Message-ID: <20030303045525.GD13705@kroah.com>
References: <1046665376.15584.29.camel@nirvana.flat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046665376.15584.29.camel@nirvana.flat>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 05:22:56PM +1300, mdew wrote:
> 
> -- 
> mdew <mdew@mdew.dyndns.org>

Content-Description: Forwarded message - [Stv0680-usb-general] USB error?
> Date: 03 Mar 2003 15:09:52 +1300
> From: mdew <mdew@mdew.dyndns.org>
> To: stv0680-usb <stv0680-usb-general@lists.sourceforge.net>
> Subject: [Stv0680-usb-general] USB error?
> 
> nirvana:~/pencam2-0.65# ./pencam2
>  usb_claim_interface error
>  usb_claim_interface error

Read the docs for pencam :)
(Hint, the video driver is bound to the device, you need to unload it
before using the pencam program.)

greg k-h
