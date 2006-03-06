Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWCFMSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWCFMSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 07:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWCFMSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 07:18:14 -0500
Received: from main.gmane.org ([80.91.229.2]:26762 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932140AbWCFMSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 07:18:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: [RFC] Encrypting file system
Date: Mon, 6 Mar 2006 13:17:53 +0100
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <duh99h$i66$1@sea.gmane.org>
References: <Pine.LNX.4.64.0603061600540.16555@vattikonda.junta.iitk.ac.in>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54b89798.dip0.t-ipconnect.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

V Bhanu Chandra <vbhanu.lkml@gmail.com> wrote:
> I am thinking of designing and implementing a new native encrypting
> file system for the linux kernel as a part of a student / research
> project. Unlike dm-crypt/loop-AES/cryptoloop, I plan to target
> slightly more ambitious user specifications such as: per-file random
> secret encryption keys which are in-turn encrypted using the public
> keys of all users having access to that filesystem object (a copy
...
> Any comments / guidance / suggestions are most welcome and solicitated.

Since you are talking about an encrypting filesystems but only
referencing encrypting block devices... Have you had a look at encfs
and/or StegFS already?
At least one of the encrypting block devices you mentioned (I don't
remember which one) already has the ability to have multiple keys.


regards
   Mario
-- 
I have great faith in fools; self-confidence my friends call it.
                                              -- Edgar Allan Poe

