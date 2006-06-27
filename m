Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWF0T66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWF0T66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWF0T66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:58:58 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34008 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932548AbWF0T65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:58:57 -0400
Subject: Re: I can cause kernel panic by using native alsa midi with
	2.6.17.1
From: Lee Revell <rlrevell@joe-job.com>
To: Knut J Bjuland <knutjbj@online.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <449B8A0D.60607@online.no>
References: <449B8A0D.60607@online.no>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 15:58:58 -0400
Message-Id: <1151438338.2899.108.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 08:28 +0200, Knut J Bjuland wrote:
> I can cause kernel panic by either alsasound stop or using a native midi player
> like pmidi. osss midi player does not cause crash.pmidi -p 17:1 midifile.
> 1./sbin/modprobe snd-emu10k1-synth
> 2./bin/asfxload *.sf2
> 3.pmidi -p 17.0 any.midi file
> 4. hit ctrl-c during playing a midi file  
> 

Should be fixed in the Alsa HG tree.

Lee


