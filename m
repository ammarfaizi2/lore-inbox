Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbUKXXml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbUKXXml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbUKXXhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:37:36 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:41805 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262938AbUKXX00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:26:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=T3u0TQmXF8UMah5qiItDWlKbtaEOKbAlRewpu1Tqye/lYw04HepSZQI9RwesuEzlld04ag7TGZwdGpSQJcEUROWt77OyuNZt5l6cRTpc54VPk405rrSx0TY9TfkjJP2pipL4GmeIb1q+vohmMqTM/T2Oa2HgvdPq8I1zJhFXhpA=
Message-ID: <8783be6604112412397b46c767@mail.gmail.com>
Date: Wed, 24 Nov 2004 15:39:28 -0500
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Ole Laursen <olau@cs.aau.dk>
Subject: Re: Isolating two network processes on same machine
Cc: linux-kernel@vger.kernel.org, d507a@cs.aau.dk
In-Reply-To: <tv8r7mj1dwr.fsf@homer.cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <tv8r7mj1dwr.fsf@homer.cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is that we need to run several instances of our network
> application on the same test machine since we have too few machines.
> But when we create two IP addresses on the same machine with
> 

The easiest solution is probably to have the FreeBSD box DNAT the
linux boxes so they don't know they are talking to themselves.  Then
you only need to use 1 ip address per linux box.

    Ross
