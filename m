Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWADJk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWADJk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWADJk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:40:28 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:7125 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751448AbWADJk1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:40:27 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Tomasz =?utf-8?q?K=C5=82oczko?= <kloczek@rudy.mif.pg.gda.pl>
Subject: [OT] ALSA userspace API complexity
Date: Wed, 4 Jan 2006 09:37:55 +0000
User-Agent: KMail/1.9
Cc: Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601040937.55624.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 23:10, Tomasz Kłoczko wrote:
[snip]
>
> 2) ALSA API is to complicated: most applications opens single sound
>    stream.

FUD and nonsense. I've written many DSP applications and very often I can 
recycle the same code for use in them. Here's an example, abstracted, 
commented, handling errors from the subsystem, in just over 100 LOC.

http://devzero.co.uk/~alistair/alsa/

The API is really _only_ complicated because it expects you to set things OSS 
either can't handle or doesn't allow you to configure. Things that very often 
an application will eventually care about. All this for the sake of 5 minutes 
reading documentation, and each API call almost identical in design.

Personally, I found the lack of documentation for some of the setup API 
annoying, but it's since been rectified and each call is humanly 
understandable.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
