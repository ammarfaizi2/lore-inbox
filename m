Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136098AbREGNmZ>; Mon, 7 May 2001 09:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136104AbREGNmP>; Mon, 7 May 2001 09:42:15 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:6584 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id <S136098AbREGNmA>; Mon, 7 May 2001 09:42:00 -0400
Message-ID: <3AF6A697.22370520@rz.tu-ilmenau.de>
Date: Mon, 07 May 2001 15:43:51 +0200
From: Alexander Eichhorn <alexander.eichhorn@rz.tu-ilmenau.de>
Reply-To: alexander.eichhorn@rz.tu-ilmenau.de
Organization: Technical University Ilmenau
X-Mailer: Mozilla 4.7 [de] (WinNT; I)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Question] Explanation of zero-copy networking
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

we are currently developing (as part of my dissertation)
a research-platform to study some new ideas in 
constructing transport systems to support applications 
with realtime-requirements (e.g. multimedia) and new 
networking technologies. The test-platform consists of 
typical multimedia-elements, such as sources, filters, 
sinks and transport-modules, which can be distributed 
across a set of computers. 

To achieve the principle of sparing ressource-usage - which 
we consider fundamental for multimedia-systems - we are 
looking for new (already implemented or planned) mechanisms to 
avoid copying the data-streams where possible (Device-IO, 
especially Network-IO; User-User-IPC). 

That's why i'd like to ask if one of the net-core developers 
could give us a (more or less - depends on what you've 
documented so far) detailed description of the newly 
implemented zero-copy mechanisms in the network-stack. 
We are interested in how to use it (changed network-API?) 
and also in the internal architecture. 

We already had a look at the kernel mailingslist 
archieves and some search machines, but all we found 
were some fragments of the puzzle only. Before digging into 
the sourcecode we try this way to get an overall description.


Our second question: Are there any plans for contructing 
a general copy-avoidance infrastructure (smth. like UVM in 
NetBSD does) and new IPC-mechanisms on top of it yet??


Thanks in advance.

Alexander Eichhorn


-- 
Alexander Eichhorn
Technical University of Ilmenau
Computer Science And Automation Faculty
Distributed Systems and Operating Systems Department
Phone +49 3677 69 4557, Fax  +49 3677 69 4541
