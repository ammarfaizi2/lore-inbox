Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272343AbRH3RDx>; Thu, 30 Aug 2001 13:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272342AbRH3RDn>; Thu, 30 Aug 2001 13:03:43 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:46096 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272341AbRH3RD3>;
	Thu, 30 Aug 2001 13:03:29 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108301703.TAA05549@nbd.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <20010830165447Z16272-32385+540@humbolt.nl.linux.org>
 "from Daniel Phillips at Aug 30, 2001 07:01:25 pm"
To: Daniel Phillips <phillips@bonn-fries.net>
Date: Thu, 30 Aug 2001 19:03:39 +0200 (CEST)
CC: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Daniel Phillips wrote:"
> More than anything, it shows that education is needed, not macro patch-ups.
> We have exactly the same issues with < and >, should we introduce 
> three-argument macros to replace them?

# define le(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) == _a ; })
# define ge(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) == _b ; })

;-)

Peter
