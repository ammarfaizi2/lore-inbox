Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVATPWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVATPWa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVATPWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:22:30 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:9427
	"HELO fargo") by vger.kernel.org with SMTP id S262149AbVATPWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:22:21 -0500
Date: Thu, 20 Jan 2005 16:20:27 +0100
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intel8x0 and 2.6.11-rc1
Message-ID: <20050120152027.GA18754@fargo>
Mail-Followup-To: Narayan Desai <desai@mcs.anl.gov>,
	linux-kernel@vger.kernel.org
References: <87hdlcc06e.fsf@topaz.mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87hdlcc06e.fsf@topaz.mcs.anl.gov>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Narayan ;),

On Jan 19 at 08:19:05, Narayan Desai wrote:
> I am running 2.6.11-rc1 (patched with software suspend2) and no longer
> get any sound output from my sound card. My old kernel 2.6.10 (with
> slightly older software suspend 2 patches) works perfectly. the
> hardware is recognized, and it appears to work, other than the lack
> out of output. I have also checked the standard volume levels type
> stuff.  Updating to the latest alsa bk patch (from 2.6.11-rc1-mm1)
> doesn't fix it. Can anyone suggest what the problem might be? 

Check that the driver snd_i8x0m (for the modem) is not being loaded.
Although i don't think this is your problem because is broken too in 
2.6.10...

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
