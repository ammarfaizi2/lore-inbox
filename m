Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTHTNCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 09:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbTHTNCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 09:02:05 -0400
Received: from locust.csie.ncku.edu.tw ([140.116.247.131]:35249 "EHLO
	locust.csie.ncku.edu.tw") by vger.kernel.org with ESMTP
	id S261950AbTHTNCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 09:02:03 -0400
Date: Wed, 20 Aug 2003 20:58:17 +0800 (CST)
From: Po-Chou Su <supc@locust.csie.ncku.edu.tw>
Message-Id: <200308201258.h7KCwHX13212@locust.csie.ncku.edu.tw>
Content-Type: text
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
If the current code with Linux kernel 2.4.18 will also pick up the first one address it finds ?
 
I tried my desktop, it always choose the same ipv6 address to internet, but when I check the 
soure code, shows as below
/*
 * Choose an apropriate source address
 * should do:
 * i) get an address with an apropriate scope
 * ii) see if there is a specific route for the destination and use
 *  an address of the attached interface 
 * iii) don't use deprecated addresses
 */
int ipv6_get_saddr(struct dst_entry *dst,
     struct in6_addr *daddr, struct in6_addr *saddr)
Why this does not work ? or when it will work ?
 
Thanks for your suggestion.
PC

