Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131831AbRCOULN>; Thu, 15 Mar 2001 15:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRCOUKx>; Thu, 15 Mar 2001 15:10:53 -0500
Received: from mail.cps.matrix.com.br ([200.196.9.5]:63495 "EHLO
	mail.cps.matrix.com.br") by vger.kernel.org with ESMTP
	id <S131831AbRCOUKr>; Thu, 15 Mar 2001 15:10:47 -0500
Date: Thu, 15 Mar 2001 17:09:47 -0300
To: Zack Weinberg <zackw@stanford.edu>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: 2.2.19 pre13 doesn't like retransmitted SYN ACK packets
Message-ID: <20010315170947.C9124@godzillah>
In-Reply-To: <20010315093116.B2523@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010315093116.B2523@stanford.edu>; from zackw@stanford.edu on Thu, Mar 15, 2001 at 09:31:16AM -0800
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@rcm.org.br (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Zack Weinberg wrote:
> 2.2.19 pre13 sends an RST in response to a retransmitted SYN ACK which
> arrives after we've sent out the final ACK of the handshake.  For
> example:

Ah, that would explain the extremely crappy network conectivity I observed
with 2.2.19preX, X < 17 (15 and 16 were better, but not as good as 17 or
2.2.18).  Please try 2.2.19pre17, it is handling itself just as well as
2.2.18 here.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
