Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbRAOXpW>; Mon, 15 Jan 2001 18:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbRAOXpM>; Mon, 15 Jan 2001 18:45:12 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:29196 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S129831AbRAOXpG>;
	Mon, 15 Jan 2001 18:45:06 -0500
To: David Balazic <david.balazic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MTRR type AMD Duron/intel ?
In-Reply-To: <3A6350EA.884AC527@uni-mb.si>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 15 Jan 2001 23:45:03 +0000
Message-ID: <y7rhf30bcsg.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic <david.balazic@uni-mb.si> writes:
> A recent 2.4.0 ( not the final , but close  ) kernel prints this :
> 
> mtrr: detected mtrr type: intel
> 
> I have an AMD K7 Duron 700 CPU
> 
> Is this correct ?

Yes.  The K7 supports MTRRs exactly according to the Intel specs, as
opposed to the MTRR-like but somewhat different features that some
other x86 CPUs implement.  So while it may appear odd, it is correct.


David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
