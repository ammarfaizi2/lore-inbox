Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264299AbRFHR7J>; Fri, 8 Jun 2001 13:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264294AbRFHR67>; Fri, 8 Jun 2001 13:58:59 -0400
Received: from t2.redhat.com ([199.183.24.243]:37105 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S264299AbRFHR6s>; Fri, 8 Jun 2001 13:58:48 -0400
Message-ID: <3B211257.FC652C94@redhat.com>
Date: Fri, 08 Jun 2001 18:58:47 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-11.3smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org
Subject: Re: xircom_cb problems
In-Reply-To: <992022302.3b210f1e0e26f@eargle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:
> 
> Whoops!! Sorry, forgot the attachment.
> 
>   ------------------------------------------------------------------------
> 
> [root@iso-2146-l1 ttsig]# ping 10.10.4.254
> PING 10.10.4.254 (10.10.4.254) from 10.10.4.33 : 56(84) bytes of data.
> 64 bytes from 10.10.4.254: icmp_seq=3 ttl=255 time=590 usec
> 64 bytes from 10.10.4.254: icmp_seq=0 ttl=255 time=2.996 sec
> 64 bytes from 10.10.4.254: icmp_seq=1 ttl=255 time=2.000 sec
> 64 bytes from 10.10.4.254: icmp_seq=2 ttl=255 time=1.000 sec
> 64 bytes from 10.10.4.254: icmp_seq=7 ttl=255 time=575 usec
> 64 bytes from 10.10.4.254: icmp_seq=4 ttl=255 time=3.000 sec
> 64 bytes from 10.10.4.254: icmp_seq=5 ttl=255 time=2.000 sec
> 64 bytes from 10.10.4.254: icmp_seq=6 ttl=255 time=1.000 sec
> 

This matches exactly with what I think is the problem; now to find the
code
that causes it...
