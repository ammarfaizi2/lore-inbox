Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWA3Iuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWA3Iuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWA3Iuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:50:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51674 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932132AbWA3Iuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:50:35 -0500
Subject: Re: insmod error
From: Arjan van de Ven <arjan@infradead.org>
To: sarat <saratkumar.koduri@gmail.com>
Cc: Fawad Lateef <fawadlateef@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <aed62bae0601292111s38714b3bsd2c58abc83188aea@mail.gmail.com>
References: <aed62bae0601292023l641fb644k870a2b1b099e6dc3@mail.gmail.com>
	 <1e62d1370601292104s3e8ad2bcx2d67e626cac04c8a@mail.gmail.com>
	 <aed62bae0601292111s38714b3bsd2c58abc83188aea@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 09:50:30 +0100
Message-Id: <1138611030.2977.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 10:41 +0530, sarat wrote:
> this is the error given in 'dmesg' hope this is okay..
> firewall: module license 'unspecified' taints kernel.
> firewall: Unknown symbol register_firewall
> firewall: Unknown symbol unregister_firewall


same question as was asked last week. This module is not compatible with
2.6.10 and later, and needs rewriting to be compliant with the 2.4/2.6
firewall (as opposed to the 2.2 kernel firewall).


