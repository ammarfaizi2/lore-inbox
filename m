Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTEKFms (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 01:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTEKFms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 01:42:48 -0400
Received: from pophost.cs.tamu.edu ([128.194.130.106]:24211 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id S263458AbTEKFmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 01:42:47 -0400
Date: Sun, 11 May 2003 00:55:28 -0500 (CDT)
From: Xinwen Fu <xinwenfu@cs.tamu.edu>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: it is a lab environment 
In-Reply-To: <200305102353_MC3-1-385A-BC34@compuserve.com>
Message-ID: <Pine.GSO.4.44.0305110038170.16534-100000@unix.cs.tamu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,
>
> > The switching table is
> > messed up by the intense traffic, we believe. Other cheaper switches
> > (netgear fast esthernet switch FS108 ) have the same problem.
>
>   What do you mean by "intense traffic?"  Many switches will get
> confused if you fill their tables with a large number of different
> addresses.  Is someone maybe spoofing MAC addresses on your net?
> Or is the switch plugged into a larger switched network where it will
> see many different MAC addresses on the uplink port?

	By Intense traffic I mean that the traffic on one path through the
switch is a little more than 10mb/s.

	My testing enviroment is an isolated lab environment. I only use
4 ports and the uplink port is not used. Each of the 4 ports is
connected to one ethernet card. That is why I concluded that the
10mb/s traffic is intense since for the first 5 minutes the switch is a
switch and then becomes a hub.

	As I said, I used a little expensive swicth (also auto-sensing
dumb one) and solved the problem. That is why I concluded a very cheap
swicth (<$100) may be not good in some scenarios. Of course for household
use,
it is definitely a good choice.

Xinwen Fu
P.S. I only intend to provide some information and all my testing is for
a rigid academic objective.

