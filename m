Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWD1VtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWD1VtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 17:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWD1VtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 17:49:15 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:10694 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751107AbWD1VtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 17:49:15 -0400
Date: Fri, 28 Apr 2006 17:49:11 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Stephen Hemminger <shemminger@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
 security: AppArmor - Overview
In-Reply-To: <20060428090425.160194e6@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604281742001.22310@d.namei>
References: <1146229328.11817.73.camel@moss-spartans.epoch.ncsc.mil>
 <20060428154928.40409.qmail@web36603.mail.mud.yahoo.com>
 <20060428090425.160194e6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006, Stephen Hemminger wrote:

> SELinux on the other hand takes a real security view of the world. If
> you have ever worked with real security environment with "need to
> know", you will understand that it is hard to keep secure and requires
> too many restrictions for normal users.

It depends on the type of SELinux policy you have loaded.  The one which 
most people use, "targeted policy", is aimed at confining network facing 
services while allowing the local user level stuff to run generally 
without confinement.


- James
-- 
James Morris
<jmorris@namei.org>
