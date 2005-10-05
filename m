Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbVJETJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbVJETJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbVJETJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:09:43 -0400
Received: from amdext3.amd.com ([139.95.251.6]:20405 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1030331AbVJETJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:09:42 -0400
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Wed, 5 Oct 2005 13:27:11 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: lsorense@csclub.uwaterloo.ca
cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: AMD Geode GX/LX support V2
Message-ID: <20051005192711.GC1548@cosmic.amd.com>
References: <20051005164626.GA25189@cosmic.amd.com>
 <20051005165405.GB25189@cosmic.amd.com>
 <20051005182947.GE8011@csclub.uwaterloo.ca>
MIME-Version: 1.0
In-Reply-To: <20051005182947.GE8011@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5AFB652KW16251-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which of those options apply to the SC1200 version of the geode

if anything it would be the GEODEGX1 option, but i486 would work just as 
well.

> it use the same ide controller driver as the cs55x0 you had in your
> previous patch?

No - the SC1200 and GX1 use the cs5530 companion chip which has a different
IDE engine then the CS5535.

> I currently build a 486 kernel for use on the sc1200 and it seems to run
> pretty good that way.

Yes - as far as the kernel is concerned, the sc1200 should be very close to a
486.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

