Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSKVGSF>; Fri, 22 Nov 2002 01:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSKVGSE>; Fri, 22 Nov 2002 01:18:04 -0500
Received: from 12-234-95-123.client.attbi.com ([12.234.95.123]:43552 "HELO
	hellmouth.digitalvampire.org") by vger.kernel.org with SMTP
	id <S265108AbSKVGSE>; Fri, 22 Nov 2002 01:18:04 -0500
To: "dan carpenter" <error27@email.com>
Cc: linux-kernel@vger.kernel.org, smatch-kbugs@lists.sourceforge.net,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: [LIST] large local declarations
References: <20021121215458.8534.qmail@email.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@digitalvampire.org>
Date: 21 Nov 2002 22:25:06 -0800
In-Reply-To: <20021121215458.8534.qmail@email.com>
Message-ID: <87vg2q15q5.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "dan" == dan carpenter <error27@email.com> writes:

    dan> I have a smatch script (smatch.sf.net) that finds the the
    dan> size of local variables.  I created an allyesconfig with
    dan> 2.5.48 and tested it.  These were the functions that declared
    dan> local datas with size of 5 digits or more (in bits).

This is a minor complaint, but... why do you report the data sizes in
bits?  I find myself forced to mentally divide every size by 8.  Every
variable (obviously) has a size that's a whole number of bytes.  Why
not just report bytes?

Best,
  Roland
