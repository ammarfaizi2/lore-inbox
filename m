Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSHZWML>; Mon, 26 Aug 2002 18:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318426AbSHZWML>; Mon, 26 Aug 2002 18:12:11 -0400
Received: from barkley.vpha.health.ufl.edu ([159.178.78.160]:17052 "EHLO
	barkley.vpha.health.ufl.edu") by vger.kernel.org with ESMTP
	id <S318407AbSHZWMK>; Mon, 26 Aug 2002 18:12:10 -0400
Message-ID: <1030400196.3d6aa8c46b8ff@webmail.health.ufl.edu>
Date: Mon, 26 Aug 2002 18:16:36 -0400
From: sridhar vaidyanathan <sridharv@ufl.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 sys_unlink
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 163.181.250.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_unlink in 2.4 calls path_walk which does a lookup. There is also 
a "restricted" lookup called lookup_hash which is called after that, which 
actually returns the dentry. Why is it done this way? Why cant the dentry be 
got from path_walk itself. Correct me if I am wrong. 
I am not subscribed - so send me n email
-sridhar
