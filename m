Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUCKWjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCKWjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:39:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25562 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261792AbUCKWjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:39:05 -0500
Date: Thu, 11 Mar 2004 17:38:55 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Voicu Liviu <pacman@mscc.huji.ac.il>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RedHat advanced server 3
In-Reply-To: <404F71A1.1040409@mscc.huji.ac.il>
Message-ID: <Pine.LNX.4.44.0403111736270.29254-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Voicu Liviu wrote:

> Any 1 know if I can install a standard kernel like 2.4.25 or 2.6x on 
> RedHat Advanced Server ver 3?

RHEL 3 works ok with a 2.6 kernel if you download arjan's
2.6 utilities, from people.redhat.com.

> Right now it does run kernrel 2.4.9-e.38custom

That kernel is AS2.1.  Due to lack of NPTL it doesn't work
correctly with everything in RHEL3 userspace...

Are you sure you're running RHEL3 and not AS2.1 ?

(btw, note that changing your kernel doesn't make the
 support people happy, and as a consequence probably
 means they won't want to help you ... read the fine
 print)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

