Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbUAMRTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUAMRTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:19:44 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:31880
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S264459AbUAMRTn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:19:43 -0500
Subject: Re: [NFS][2.4][ReiserFS] NFS and `nohide' vs. reiserfs
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87eku3u6pq.wl@canopus.ns.zel.ru>
References: <87eku3u6pq.wl@canopus.ns.zel.ru>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074014378.1526.53.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 13 Jan 2004 12:19:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 13/01/2004 klokka 11:57, skreiv Samium Gromoff:
> Participants:
> 
> - a 2.4.18 server exporting with a `nohide' option a reiserfs filesystem A
> with a reiserfs filesystem B mounted in it.
> 

Mind showing us your /etc/exports? I'll bet you have the "nohide" option
set on the wrong entry.

"nohide" should set be on the /etc/exports entry for "B" if the latter
is mounted inside "A". It does not have to be set on the entry for "A".

Cheers,
  Trond
