Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291578AbSBNMZm>; Thu, 14 Feb 2002 07:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291565AbSBNMZh>; Thu, 14 Feb 2002 07:25:37 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:54801 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S291562AbSBNMZ1>; Thu, 14 Feb 2002 07:25:27 -0500
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: RFC: /proc key naming consistency
Date: 14 Feb 2002 13:25:24 +0100
Organization: Cistron Internet Services
Message-ID: <a4gabk$dpl$1@picard.cistron.nl>
In-Reply-To: <Pine.LNX.4.33.0202141020140.5260-100000@dbsydn2001.aus.deuba.com> <a4ga1d$jov$1@ncc1701.cistron.net>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <a4ga1d$jov$1@ncc1701.cistron.net>,
Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>You could have /proc/sys/cpu/0/processor
>               /proc/sys/cpu/0/vendor_id
>               /proc/sys/cpu/0/family
>
>... and a /proc/sys/cpu/0/.table that when read produces

And then instead of using those names use standard MIB names and add
symlinks for assigned OID numbers and we can do SNMP using netcat
and a sh script.

Wichert.
-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

