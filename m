Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVGMRgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVGMRgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVGMRel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:34:41 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:23026 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261922AbVGMRcb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:32:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OJjOG4FGBKqOwr2VXv/pXvK0h8yR3PxPXzQvHf66t6Sk7+aA0IJZd5jrv+hlLXhpxp95C4317I4UqvlMlugO/DgS6gXdnnRdi9h3KrrlBUz9f+2gJbk6GbnuPpSgeXpE9nh5u6oihSC707RZhaTVsOZie2Y9sFU70iO8Az93+8I=
Message-ID: <d120d500050713103222aa9c91@mail.gmail.com>
Date: Wed, 13 Jul 2005 12:32:27 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
Subject: Re: Synaptics probe problem on Acer Travelmate 3004WTMi
Cc: linux-input@atrey.karlin.mff.cuni.cz, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <1121275408.3583.35.camel@playstation2.hb9jnx.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1121275408.3583.35.camel@playstation2.hb9jnx.ampr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/05, Thomas Sailer <sailer@sailer.dynip.lugs.ch> wrote:
> Hi Vojtech,
> 
> I've got a problem with my Acer Travelmate 3004WTMi Laptop: vanilla 2.6
> does not detect the synaptics touchpad.
> 
> The problem lies within psmouse_probe: after the PSMOUSE_CMD_GETID
> command, param[0] contains 0xfa, and not one of the expected values. If
> I just ignore this and continue, the synaptics pad is detected and
> everything works ok.
> 

Hi,

Could you please provide us with debug dmesg - just boot with
i8042.debug on kernel command line.

Thanks!

-- 
Dmitry
