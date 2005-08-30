Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVH3Jru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVH3Jru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 05:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVH3Jru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 05:47:50 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:15767 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750813AbVH3Jrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 05:47:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Lj9tox0dXH/3CG9Dg5jO+lrBRosyfzSf7diEwcEZzEYpaFifxDlw6pdeN+b5VDJBddm6iCJYRPZXQW7W5tItEYB1Wf07rO6rSnCzQJnnf5uVBoSZA/vhEA8UDQALlo3mNUiU6qnLnVOeUD+dkVk4HjXF419XWO4FPGkf2233KG0=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.13-rc7-rt4, fails to build
Date: Tue, 30 Aug 2005 11:50:07 +0200
User-Agent: KMail/1.8.1
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       linux-kernel@vger.kernel.org
References: <1125277360.2678.159.camel@cmn37.stanford.edu> <1125364522.7630.108.camel@cmn37.stanford.edu> <20050830062811.GA6516@elte.hu>
In-Reply-To: <20050830062811.GA6516@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508301150.07818.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. August 2005 08:28 schrieb Ingo Molnar:
> ok, managed to reproduce it with this .config. It's an effect of the 
> IOAPIC_CACHE code. I have fixed it with the patch below (which is also 
> in 2.6.13-rt2), and the resulting kernel builds & boots fine. Karsten, 
> does it look sane to you?

Sure.

   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
