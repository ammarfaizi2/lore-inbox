Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262923AbTCKNnR>; Tue, 11 Mar 2003 08:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262926AbTCKNnR>; Tue, 11 Mar 2003 08:43:17 -0500
Received: from pcp749571pcs.manass01.va.comcast.net ([68.49.125.82]:37013 "EHLO
	pcp749571pcs.manass01.va.comcast.net") by vger.kernel.org with ESMTP
	id <S262923AbTCKNnQ>; Tue, 11 Mar 2003 08:43:16 -0500
Date: Tue, 11 Mar 2003 08:53:50 -0500
To: Paul Rolland <rol@as2917.net>
Cc: "'Kernel List'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64 boot problems
Message-ID: <20030311135350.GA5410@bittwiddlers.com>
References: <20030310184052.GA1623@bittwiddlers.com>
	<00c001c2e79a$5567c8c0$3f00a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c001c2e79a$5567c8c0$3f00a8c0@witbe>
User-Agent: Mutt/1.5.3i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1047822834.58010f@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried that with 2.5.64-bk5 and it didn't help.  Still hung at the same 
place.  This was with CONFIG_X86_UP_APIC unset which got rid of the following

  CONFIG_X86_UP_APIC
  CONFIG_X86_UP_IOAPIC
  CONFIG_X86_LOCAL_APIC
  CONFIG_X86_IO_APIC


: Could you try the same config without APIC and IO APIC for Uniprocessor
: ?
: I've a problem that is directly related to 2.5.64 and these features...
: 
: Without them, 2.5.64 just boots fine...

-- 
  Matthew Harrell                          Every morning is the dawn of a
  Bit Twiddlers, Inc.                       new error.
  mharrell@bittwiddlers.com     
