Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUGaQAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUGaQAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 12:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUGaQAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 12:00:39 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:12044 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267939AbUGaQAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 12:00:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Date: Sat, 31 Jul 2004 09:00:34 -0700
Message-ID: <3689AF909D816446BA505D21F1461AE4C750E6@cacexc04.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Thread-Index: AcR3DHBpIYFUsDJ/RJ6t9lMRrdmKSQAAqFmA
From: "Walker, Bruce J" <bruce.walker@hp.com>
To: "Discussion of clustering software components including GFS" 
	<linux-cluster@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <opengfs-devel@lists.sourceforge.net>,
       <opengfs-users@lists.sourceforge.net>,
       <opendlm-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 31 Jul 2004 16:00:35.0071 (UTC) FILETIME=[83B2E8F0:01C47717]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin,
   Got out of bed on the wrong side?  Such anger.  First, the
clusterwide device capability is a very small part of OpenSSI so your
comment "put the entire clustering layer on top of it" is COMPLETELY
wrong - you clearly are commenting about something you know nothing
about.  In the 2.4 implementation, providing this one capability by
leveraging devfs was quite economic, efficient and has been very stable.
I'm not sure who you mean by "that's what WE want".  If you mean the
current worldwide users of OpenSSI on 2.4, they are a very happy group
with a kick-ass clustering capability.

About one thing you are correct.  We are going to have to have a way to
lookup and name remote devices in 2.6.  I believe the remote file-op
mechanism we are using in 2.4 will adapt easily.

Bruce Walker
Architect and project manager - OpenSSI project



> -----Original Message-----
> From: linux-cluster-bounces@redhat.com 
> [mailto:linux-cluster-bounces@redhat.com] On Behalf Of Kevin 
> P. Fleming
> Sent: Saturday, July 31, 2004 7:41 AM
> To: Linux Kernel Mailing List
> Cc: linux-cluster@redhat.com; 
> opengfs-devel@lists.sourceforge.net; 
> opengfs-users@lists.sourceforge.net; 
> opendlm-devel@lists.sourceforge.net
> Subject: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
> 
> 
> Aneesh Kumar K.V wrote:
> 
> > 5. Devices
> >   * there is a clusterwide device model via the devfs code
> 
> Yeah, that's we want, take buggy, unreliable, 
> soon-to-be-removed-from-mainline code and put an entire 
> clustering layer 
> on top of it. Too bad someone is going to need to completely 
> reimplement 
> this "clusterwide device model".
> 
> --
> Linux-cluster mailing list
> Linux-cluster@redhat.com
> http://www.redhat.com/mailman/listinfo/linux-cluster
> 
