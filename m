Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTH1TJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264209AbTH1TJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:09:50 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:30747 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S264201AbTH1TJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:09:46 -0400
Date: Thu, 28 Aug 2003 22:09:29 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030828190929.GH83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org
References: <20030729073948.GD204266@niksula.cs.hut.fi> <20030730071321.GV150921@niksula.cs.hut.fi> <Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva> <20030730181003.GC204962@niksula.cs.hut.fi> <20030827064301.GF150921@niksula.cs.hut.fi> <20030827110417.GY83336@niksula.cs.hut.fi> <20030827133055.0f7aaf6e.skraw@ithnet.com> <20030828112630.E639@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030828112630.E639@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 11:26:30AM +0200, you [Ingo Oeser] wrote:
> 
> But heavy (disk) IO and misterious crashes sound like power problems,
> doesn't it?

Hmm. It doesn't crash, it locks up solid. (Well the aic7xxx driver sometimes
crashes (spits a huge log of errors, rather), but I'm still not sure if
that's related.)

The box only has two disks, 1.3GHz Celeron (~30W), and other lighter power
consumers. Not exactly a power hungry config. I'm not sure about the power
supply - I think it's a 250W one - I'll have to check.

Accoring to sensors, the voltages do not fluctuate much. Also, the
temperatures are moderate (34.0°C system, 41.0°C CPU).

Power problems are surely possible, but don't exactly sound like promising
lead to me. 


-- v --

v@iki.fi
