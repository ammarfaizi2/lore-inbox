Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275702AbTHOIGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 04:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275705AbTHOIGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 04:06:47 -0400
Received: from main.gmane.org ([80.91.224.249]:4027 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S275702AbTHOIGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 04:06:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Date: Fri, 15 Aug 2003 10:06:42 +0200
Message-ID: <yw1xfzk3pcod.fsf@users.sourceforge.net>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think>
 <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14>
 <bhgoj9$9ab$1@abraham.cs.berkeley.edu>
 <20030815001713.GD5333@speare5-1-14>
 <20030815093003.A2784@pclin040.win.tue.nl>
 <20030815004004.52f94f9a.davem@redhat.com>
 <20030815095503.C2784@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:bqj6xdT9gtV7hFBOWSx7l+uEHIk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

>> > > entropy(x) >= entropy(x xor y)
>> > > entropy(y) >= entropy(x xor y)
>> > 
>> > Is this trolling? Are you serious?
>> 
>> These lemma are absolutely true.
>
> David, did you read this line:
>
>> > Try to put z = x xor y and apply your insight to the strings x and z.
>
> Let us do it. Let z be an abbreviation for x xor y.
>
> The lemma that you believe in, applied to x and z, says
>
>  entropy(x) >= entropy(x xor z)
>  entropy(z) >= entropy(x xor z)
>
> But x xor z equals y, so you believe for arbitrary strings x and y that
>
>  entropy(x) >= entropy(y)
>  entropy(x xor y) >= entropy(y).
>
> This "lemma", formulated in this generality, is just plain nonsense.

Not quite non-sense, but it would mean that for any strings x and y, 

  entropy(x) == entropy(y),

which seems incorrect.

-- 
Måns Rullgård
mru@users.sf.net

