Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266433AbUA2VJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 16:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUA2VJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 16:09:20 -0500
Received: from palrel11.hp.com ([156.153.255.246]:45778 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S266422AbUA2VJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 16:09:17 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16409.30329.336793.50051@napali.hpl.hp.com>
Date: Thu, 29 Jan 2004 13:09:13 -0800
To: Matthias Fouquet-Lapar <mfl@kernel.paris.sgi.com>
Cc: davidm@hpl.hp.com, ak@suse.de (Andi Kleen), davidm@napali.hpl.hp.com,
       iod00d@hp.com, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
In-Reply-To: <200401292016.i0TKGraI034387@mtv-vpn-hw-mfl-2.corp.sgi.com>
References: <16409.24257.589224.818006@napali.hpl.hp.com>
	<200401292016.i0TKGraI034387@mtv-vpn-hw-mfl-2.corp.sgi.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 29 Jan 2004 21:16:52 +0100 ("CET), Matthias Fouquet-Lapar <mfl@kernel.paris.sgi.com> said:

  Matthias> We have done a rather large study with DIMMs that had SBEs
  Matthias> I should have been more precice. We used field returned
  Matthias> parts which had reported SBEs and had been exchanged in
  Matthias> the field. Our goal was to see if any of these parts
  Matthias> "de-generate" over time. Most of these parts had hard
  Matthias> single bit failures in one or more locations.

Ah, that's more interesting, agreed.

  Matthias> As I said, we didn't find evidence that even hard SBEs
  Matthias> turn into a multiple bit error.

But you were changing the operating environment of the chip, so I
wouldn't draw too strong of a conclusion.  Or was the reason for the
hard SBEs known and it was determined that the operating environment
was not a factor in triggering them?

	--david
