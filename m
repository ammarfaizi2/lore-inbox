Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271192AbTGWR5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271191AbTGWR5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:57:49 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:49930 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S271192AbTGWR5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:57:08 -0400
Date: Wed, 23 Jul 2003 11:12:12 -0700
From: jw schultz <jw@pegasys.ws>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: ICMP REQUEST
Message-ID: <20030723181212.GB15719@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <E04CF3F88ACBD5119EFE00508BBB212104BCD649@exch-01.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E04CF3F88ACBD5119EFE00508BBB212104BCD649@exch-01.noida.hcltech.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This Outlook installation has been found to be susceptible to misuse.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 12:53:35PM +0530, Hemanshu Kanji Bhadra, Noida wrote:
> Hi, All
> 
> i am developing a  ping program, through my program I get ECHO_REPLY..but I
> dont get ECHO_REQUEST.
> 
> is that the ECHO_REQUEST is handled by kernel.?
> 
> please respond as it is urgent.

In most cases ICMP ECHO_REQUEST is handled by the NIC.  The
kernel doesn't even see it.  That is why you can ping a
crashed system; the NIC is still configured.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
