Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSHBFaa>; Fri, 2 Aug 2002 01:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSHBFaa>; Fri, 2 Aug 2002 01:30:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26785 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318216AbSHBFa3>;
	Fri, 2 Aug 2002 01:30:29 -0400
Date: Thu, 01 Aug 2002 22:20:53 -0700 (PDT)
Message-Id: <20020801.222053.20302294.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: gh@us.ibm.com, riel@conectiva.com.br, akpm@zip.com.au,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohit.seth@intel.com,
       sunil.saxena@intel.com, asit.k.mallick@intel.com
Subject: Re: large page patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15690.6005.624237.902152@napali.hpl.hp.com>
References: <Pine.LNX.4.44L.0208012246390.23404-100000@imladris.surriel.com>
	<E17aSCT-0008I0-00@w-gerrit2>
	<15690.6005.624237.902152@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Thu, 1 Aug 2002 22:24:05 -0700
   
   In my opinion the proposed large-page patch addresses a relatively
   pressing need for databases (primarily).

Databases want large pages with IPC_SHM, how can this special
syscal hack address that?

It's great for experimentation, but give up syscall slots for
this?
