Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVA2VFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVA2VFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 16:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVA2VFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 16:05:21 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58306 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261564AbVA2VFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 16:05:15 -0500
Subject: DRI (was Re: OpenOffice crashes due to incorrect access
	permissions on /dev/dri/card*)
From: Lee Revell <rlrevell@joe-job.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Jon Smirl <jonsmirl@gmail.com>, ee21rh@surrey.ac.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <41FBF8A0.6000708@comcast.net>
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk>
	 <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net>
	 <pan.2005.01.29.12.49.13.177016@surrey.ac.uk>
	 <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
	 <9e473391050129112525f4947@mail.gmail.com>
	 <1107030966.24676.28.camel@krustophenia.net>
	 <20050129204036.GA1750@gallifrey>  <41FBF8A0.6000708@comcast.net>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 16:05:14 -0500
Message-Id: <1107032714.24676.48.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-29 at 15:57 -0500, Parag Warudkar wrote:
> Dr. David Alan Gilbert wrote:
> 
> >* Lee Revell (rlrevell@joe-job.com) wrote:
> >  
> >
> >>Stupid question: what the heck does OO use DRI for?  I googled and came
> >>up empty.
> >>    
> >>
> >
> >It does pointless 3D objects in its drawing package.
> >  
> >
> Another stupid question :)
> Does it mean DRI is only used for doing 3D? How about normal, 2D stuff? 
> I thought X uses DRI for both 2D  and 3D if it is available...
> 

No, XAA is normally used for 2D acceleration.  This is hardware
accelerated but doesn't use DRI, X does 2D accel by talking directly to
the hardware without the kernel's involvement.

This is an area where the proprietary guys are a little ahead but there
are some interesting developments like the Xgl server.

Lee



