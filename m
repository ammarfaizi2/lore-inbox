Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292656AbSCLWlc>; Tue, 12 Mar 2002 17:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292780AbSCLWlX>; Tue, 12 Mar 2002 17:41:23 -0500
Received: from dialin-145-254-225-254.arcor-ip.net ([145.254.225.254]:8632
	"EHLO duron.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S292656AbSCLWlH>; Tue, 12 Mar 2002 17:41:07 -0500
Date: Tue, 12 Mar 2002 23:41:01 +0100
From: Dominik Kubla <kubla@sciobyte.de>
To: Larry Kessler <kessler@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
Message-ID: <20020312224101.GB12952@duron.intern.kubla.de>
In-Reply-To: <3C8E7E08.C3CF4227@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8E7E08.C3CF4227@us.ibm.com>
User-Agent: Mutt/1.3.27i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 02:15:36PM -0800, Larry Kessler wrote:
> 2) If the buffer overruns the oldest events are kept, newest
>    discarded, and a count of discarded events is reported.

Hmm. That sounds like a possible security problem to me: simply generate a
bunch of harmless messages to fill the buffer and then one can do the nasty
stuff...

Dominik Kubla
-- 
ScioByte GmbH    Zum Schiersteiner Grund 2     55127 Mainz (Germany)
Phone: +49 700 724 629 83                    Fax: +49 700 724 629 84
1024D/717F16BB    A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
