Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264895AbUEYO5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbUEYO5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 10:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUEYO5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 10:57:18 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:5323 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264895AbUEYO5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 10:57:10 -0400
Subject: Re: Modifying kernel so that non-root users have some root
	capabilities
From: David T Hollis <dhollis@davehollis.com>
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47E6F@xch-nw-28.nw.nos.boeing.com>
References: <67B3A7DA6591BE439001F2736233351202B47E6F@xch-nw-28.nw.nos.boeing.com>
Content-Type: text/plain
Date: Tue, 25 May 2004 10:57:38 -0400
Message-Id: <1085497058.3270.4.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-24 at 15:21 -0700, Laughlin, Joseph V wrote:
> (not sure if this is a duplicate or not.. Apologies in advance.)
> 
> I've been tasked with modifying a 2.4 kernel so that a non-root user can
> do the following:
> 
> Dynamically change the priorities of processes (up and down)
> Lock processes in memory
> Can change process cpu affinity
> 
> Anyone got any ideas about how I could start doing this?  (I'm new to
> kernel development, btw.)
> 
> Thanks,
> 
It's these sorts of things that make Windows so unstable.  As others
have suggested, the considerably safer alternatives have already
surfaced, been around, had the tires kicked etc. in the form of setuid,
sudo, or kernel capabilities.  Some of these things may even be possible
from SELinux, but I'm not certain.

-- 
David T Hollis <dhollis@davehollis.com>

