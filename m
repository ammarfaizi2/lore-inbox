Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWBBV4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWBBV4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWBBV4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:56:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:34196 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932320AbWBBV4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:56:48 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: Lee Revell <rlrevell@joe-job.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch
In-Reply-To: <20060202214938.GF10352@voodoo>
References: <43DF3C3A.nail2RF112LAB@burner>
	 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
	 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
	 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
	 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
	 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
	 <20060202210949.GD10352@voodoo> <1138915551.15691.123.camel@mindpipe>
	 <20060202214938.GF10352@voodoo>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 16:56:45 -0500
Message-Id: <1138917406.15691.141.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 16:49 -0500, Jim Crilly wrote:
> On 02/02/06 04:25:50PM -0500, Lee Revell wrote:
> > On Thu, 2006-02-02 at 16:09 -0500, Jim Crilly wrote:
> > > Apparently O_EXCL was added by Ubuntu and Debian to stop
> > > burns being corrupted by hald polling the device while a disc is
> > > being burned. 
> > 
> > IO priorities are the correct solution...
> > 
> > Lee
> 
> Is this something that's available now?
> 

Hmm, actually I'm not sure it would make a difference, as I don't think
CD writing goes through the regular IO scheduler.

Lee

