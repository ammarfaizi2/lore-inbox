Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbUCJGRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 01:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUCJGRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 01:17:20 -0500
Received: from ext-ch1gw-3.online-age.net ([216.34.191.37]:55437 "EHLO
	ext-ch1gw-3.online-age.net") by vger.kernel.org with ESMTP
	id S262281AbUCJGQt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 01:16:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6521.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: (0 == foo), rather than (foo == 0)
Date: Wed, 10 Mar 2004 11:46:40 +0530
Message-ID: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: (0 == foo), rather than (foo == 0)
Thread-Index: AcQGZ2o1g+OfH4jMTjGgADeRZVA0HQ==
From: "Godbole, Amarendra \(GE Consumer & Industrial\)" 
	<Amarendra.Godbole@ge.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Mar 2004 06:16:43.0970 (UTC) FILETIME=[4276DA20:01C40667]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While writing code, the assignment operator (=) is many-a-times confused with the comparison operator (==) resulting in very subtle bugs difficult to track. To keep a check on this -- the constant can be written on the LHS rather than the RHS which will result in a compile time error if wrong operator is used.

Is this an encouraged practice while writing any code for the kernel ? Or is this choice left to the developer ? I was unable to find any reference to it in the CodingStyle document. I did find some code under drivers/ which used (NULL == foo) and similar constructs. 

Can this be added to the CodingStyle document ?

Cheers,
Amarendra

--
#include <std$disclaimer.h>
