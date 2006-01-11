Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWAKDcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWAKDcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbWAKDcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:32:31 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:58777 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932622AbWAKDca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:32:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jC8iY9r3N5siLAc0BpOtjcgyIbW4KKP5gR8gnAJkXo3tawdEz37wI+ORyqOSGqM1yWiSJeAeodug+zDXlBC7fpZnjoCVfIN9RB6yJVEH9hUqT9SbynFLxPDIYLAUrRWLG3DBf/ez4DdDnKlmAR/aQUW3IrIHSm9Tv5chw3jruTg=  ;
Message-ID: <20060111033229.5590.qmail@web31809.mail.mud.yahoo.com>
Date: Tue, 10 Jan 2006 19:32:29 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: git pull on Linux/ACPI release tree
To: Kyle Moffett <mrmacman_g4@mac.com>,
       Martin Langhoff <martin.langhoff@gmail.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, "Brown, Len" <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>,
       Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Kyle Moffett <mrmacman_g4@mac.com> wrote:
> they're totally irrelevant.  This is why it's useful to only pull  
> mainline into your tree (EX: ACPI) when you functionally depend on  
> changes there (as Linus so eloquently expounded upon).

Sometimes the dependency is _behavioural_.  For example certain
behaviour of other modules of the kernel changed and you want
to test that your module works ok with them under different
behaviour.  In which case you may or may not have to
change your code after the fact.

    Luben

