Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTA3RXl>; Thu, 30 Jan 2003 12:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbTA3RXl>; Thu, 30 Jan 2003 12:23:41 -0500
Received: from sark.cc.gatech.edu ([130.207.7.23]:18371 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S267491AbTA3RXk>; Thu, 30 Jan 2003 12:23:40 -0500
Date: Thu, 30 Jan 2003 12:33:04 -0500 (EST)
From: Abhishek Singh <abhi@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: Secure usage of netfilter hooks
Message-ID: <Pine.LNX.4.44.0301301229130.22137-100000@novascotia-lnx.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Is it possible for a netfilter hook registered during module insertion 
time to be removed by a userspace application (such as iptables) without 
the insertion of a new module? 

What I am trying to do is implement a hook for secure packet processing 
using netfilter. If however an attacker can remove this hook without 
inserting a new module or compromising the kernel in some way then the 
security level of this hook is compromised. 

-- 

Thanks and Regards,

  -abhi


