Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293238AbSCEPC0>; Tue, 5 Mar 2002 10:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293297AbSCEPCQ>; Tue, 5 Mar 2002 10:02:16 -0500
Received: from h00403399c977.ne.mediaone.net ([24.218.248.214]:15824 "EHLO
	fred.cambridge.ma.us") by vger.kernel.org with ESMTP
	id <S293238AbSCEPCB>; Tue, 5 Mar 2002 10:02:01 -0500
From: pjd@fred001.dynip.com
Message-Id: <200203051459.g25Ex5x02563@fred.cambridge.ma.us>
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 5 Mar 2002 09:59:05 -0500 (EST)
Cc: key@austin.ibm.com (Kent Yoder), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <3C83C698.25D28157@mandrakesoft.com> from "Jeff Garzik" at Mar 04, 2002 02:10:16 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> MWI -does- make a difference in performance, though you may need to
> check lanstreamer docs to see if there is a chip-specific MWI bit you
> need to enable, over and above the PCI_COMMAND bit.

My experience - which is 2-3 years old now - is that many BIOSes will
enable MWI for you.  Which makes it very easy to forget to do this,
and then have it discovered by your customers who have machines that
don't set MWI...

............................................................................
 Peter Desnoyers 
 162 Pleasant St.         (617) 661-1979          pjd@fred.cambridge.ma.us
 Cambridge, Mass. 02139

