Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVIHM4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVIHM4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 08:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVIHM4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 08:56:41 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:52876 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932496AbVIHM4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 08:56:41 -0400
Message-ID: <011f01c5b475$77eef710$1b00a8c0@cruncher>
Reply-To: "Mike Kirk" <mike.kirk@sympatico.ca>
From: "Mike Kirk" <mike.kirk@sympatico.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Multipath routing changes? "[kernel] Badness in dst_release at include/net/dst.h:154" [FIXED]
Date: Thu, 8 Sep 2005 09:01:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently CONFIG_IP_ROUTE_MULTIPATH_CACHED collides with the routes
patches, so if it's disabled everything works again. Thanks to patch
maintainer Julian Anastasov for figuring it out!

Regards,

   Mike

