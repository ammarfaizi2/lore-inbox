Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUGICOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUGICOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUGICOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:14:15 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:48762 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262382AbUGICOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:14:12 -0400
Message-ID: <40EDFF70.5060906@yahoo.com.au>
Date: Fri, 09 Jul 2004 12:14:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au> <20040708023001.GN21066@holomorphy.com> <m2briq7izk.fsf@telia.com> <20040708193956.GO21066@holomorphy.com> <40EDED5D.80605@yahoo.com.au> <20040709015317.GR21066@holomorphy.com> <40EDFDBE.5040805@yahoo.com.au> <20040709020905.GT21066@holomorphy.com>
In-Reply-To: <20040709020905.GT21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> 
> Enumerate those more basic things.
> 

Why does it fail when laptop_mode is set, and not otherwise?
Proably by the time laptop mode decides to start writing something,
the scanner is ready to call it quits and go OOM. Maybe laptop
mode needs to fire up the disk and do another pass before OOM.

