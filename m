Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUBSBIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUBSBIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:08:23 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:65177 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S267313AbUBSBIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:08:22 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: <tridge@samba.org>, "'Pascal Schmidt'" <der.eremit@email.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: UTF-8 and case-insensitivity
Date: Wed, 18 Feb 2004 17:08:10 -0800
Organization: Cisco Systems
Message-ID: <011d01c3f684$d74539a0$613a47ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <16436.2817.900018.285167@samba.org>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that Samba isn't the only program to be accessing these
> directories. Multi-protocol file servers and file servers where users
> also have local access are common. That means we can't assume that
> some other filesystem user hasn't created a file which matches in a
> case-insensitive manner. That means we need to do an awful lot of
> directory scans.

Do you also require NFSD or other file daemons to do the same
case-insensitivity check? Say you create a foo, how do you prevent NFSD
from creating FOO? What could you do about that?


