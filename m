Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVCHRtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVCHRtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVCHRtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:49:05 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:3252 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261444AbVCHRtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:49:02 -0500
Date: Tue, 8 Mar 2005 18:49:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Hans-Christian Egtvedt <hc@mivu.no>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
Message-ID: <20050308174946.GA2202@ucw.cz>
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no> <200503041403.37137.adobriyan@mail.ru> <d120d50005030406525896b6cb@mail.gmail.com> <1109953224.3069.39.camel@charlie.itk.ntnu.no> <d120d50005030408544462c9ea@mail.gmail.com> <1110297660.3198.15.camel@server.customer.mivu.no> <d120d500050308092554b49728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050308092554b49728@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 12:25:09PM -0500, Dmitry Torokhov wrote:

> I am not sure... that BTN_TOUCH - look slike it works off a single
> flag reported by hardware. You porobably do not need to change it.

Indeed, if the hardware reports a touch flag it's best to use that.

> Try loading mousedev module (after adding input_sync back to your
> driver) - it provides cooked PS/2 protocol to userspace - it should
> bind to your driver. Then you can use GPM or X (read from
> /dev/input/mice) to test the touchscreen and see if you have issue
> with double clicks.
 
And for even better behavior, use 'evtouch' from Kenan Esau as an X
driver.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
