Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbTHYLPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbTHYLPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:15:23 -0400
Received: from main.gmane.org ([80.91.224.249]:54928 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261197AbTHYLPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:15:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH]O18.1int
Date: Mon, 25 Aug 2003 13:15:17 +0200
Message-ID: <yw1x1xvac7ju.fsf@users.sourceforge.net>
References: <200308231555.24530.kernel@kolivas.org> <200308252016.13315.kernel@kolivas.org>
 <yw1x65kmc9f2.fsf@users.sourceforge.net>
 <200308252050.04147.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:qt9hUxegSvVse+gKsoRq/WxY90Q=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

>> Vanilla test1 has the spin effect.  Test2 doesn't.  I haven't tried
>> vanilla test3 or test4.  As I've said, the O16.2-O16.3 patch
>> introduced the problem.  With that patch reversed, everything is
>> fine.  What problem does that patch fix?
>
> It's a generic fix for priority inversion but it induces badness in smp, and 
> latency in task preemption on up so it's not suitable.

Now I'm confused.  If that patch is bad, then why is it in O18?

-- 
Måns Rullgård
mru@users.sf.net

