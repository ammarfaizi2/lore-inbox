Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVEaVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVEaVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVEaVH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:07:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2248 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261492AbVEaVHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:07:15 -0400
Date: Tue, 31 May 2005 13:18:10 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.31-rc2
Message-ID: <20050531161810.GA6280@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes the second release candidate for v2.4.31.

It incorporates two small hardening fixes from Willy's -hotfix tree.

v2.4.31 will follow shortly.

PS: beginning from v2.4.31 the v2.4 tree will reside in a GIT repository.

Summary of changes from v2.4.31-rc1 to v2.4.31-rc2
============================================

Marcelo Tosatti:
  o Change VERSION to 2.4.31-rc2

Willy Tarreau:
  o off-by-one in mtrr.c found by Brad Spengler and reported by Julien Tinnes
  o IPVS: Replace several unchecked strcpy() with strncpy() (PaX team)

