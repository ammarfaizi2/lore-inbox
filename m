Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266792AbTAIPyk>; Thu, 9 Jan 2003 10:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266794AbTAIPyk>; Thu, 9 Jan 2003 10:54:40 -0500
Received: from home.wiggy.net ([213.84.101.140]:6047 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S266792AbTAIPyj>;
	Thu, 9 Jan 2003 10:54:39 -0500
Date: Thu, 9 Jan 2003 17:03:21 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030109160321.GA7510@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20030108130850.GQ22951@wiggy.net> <20030109123857.A15625@bitwizard.nl> <20030109155214.GX22951@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030109155214.GX22951@wiggy.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Wichert Akkerman wrote:
> It seems no packets are dropped:

And now for ipv6 statistics from /proc/net/snmp6 (thanks Jamal):

Ip6InReceives                   	27011
Ip6InHdrErrors                  	0
Ip6InTooBigErrors               	0
Ip6InNoRoutes                   	0
Ip6InAddrErrors                 	0
Ip6InUnknownProtos              	0
Ip6InTruncatedPkts              	0
Ip6InDiscards                   	0
Ip6InDelivers                   	26885
Ip6OutForwDatagrams             	0
Ip6OutRequests                  	26848
Ip6OutDiscards                  	0
Ip6OutNoRoutes                  	0
Ip6ReasmTimeout                 	0
Ip6ReasmReqds                   	0
Ip6ReasmOKs                     	0
Ip6ReasmFails                   	0
Ip6FragOKs                      	0
Ip6FragFails                    	0
Ip6FragCreates                  	0
Ip6InMcastPkts                  	40
Ip6OutMcastPkts                 	0
Icmp6InMsgs                     	123
Icmp6InErrors                   	0
Icmp6InDestUnreachs             	0
Icmp6InPktTooBigs               	0
Icmp6InTimeExcds                	0
Icmp6InParmProblems             	0
Icmp6InEchos                    	0
Icmp6InEchoReplies              	0
Icmp6InGroupMembQueries         	0
Icmp6InGroupMembResponses       	0
Icmp6InGroupMembReductions      	0
Icmp6InRouterSolicits           	0
Icmp6InRouterAdvertisements     	40
Icmp6InNeighborSolicits         	45
Icmp6InNeighborAdvertisements   	38
Icmp6InRedirects                	0
Icmp6OutMsgs                    	86
Icmp6OutDestUnreachs            	0
Icmp6OutPktTooBigs              	0
Icmp6OutTimeExcds               	0
Icmp6OutParmProblems            	0
Icmp6OutEchoReplies             	0
Icmp6OutRouterSolicits          	1
Icmp6OutNeighborSolicits        	40
Icmp6OutNeighborAdvertisements  	45
Icmp6OutRedirects               	0
Icmp6OutGroupMembResponses      	0
Icmp6OutGroupMembReductions     	0
Udp6InDatagrams                 	0
Udp6NoPorts                     	0
Udp6InErrors                    	0
Udp6OutDatagrams                	0

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
