Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271415AbTHRMNR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271423AbTHRMMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:12:07 -0400
Received: from main.gmane.org ([80.91.224.249]:41674 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271415AbTHRMLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:11:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Date: Mon, 18 Aug 2003 14:11:39 +0200
Message-ID: <yw1xzni76u84.fsf@users.sourceforge.net>
References: <20030818004313.T3708@schatzie.adilger.int> <Pine.LNX.4.44.0308172352470.20433-100000@dlang.diginsite.com>
 <20030818115954.GA7147@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:YHYQi5SPyRF7E7tmXrzDnxqDCTk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

>> now if you can repeatably get the same number then you probably have a bug
>> in the random number code, but if you need uniqueness you need something
>> else.
>
> Can you think of another, reliable, source of uniqueness?

You could use your geographical position and the exact time, both
easily available with GPS.  In case several machines are within the
GPS resolution, you could add some more parameters that would
typically be different, such as network address.

-- 
Måns Rullgård
mru@users.sf.net

