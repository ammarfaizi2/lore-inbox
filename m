Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261999AbSJDSjt>; Fri, 4 Oct 2002 14:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbSJDSjt>; Fri, 4 Oct 2002 14:39:49 -0400
Received: from khms.westfalen.de ([62.153.201.243]:1442 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S261999AbSJDSjs>; Fri, 4 Oct 2002 14:39:48 -0400
Date: 04 Oct 2002 19:29:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: corryk@us.ibm.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8YFSoA-Xw-B@khms.westfalen.de>
In-Reply-To: <02100408071900.02266@boiler>
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <02100408071900.02266@boiler>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corryk@us.ibm.com (Kevin Corry)  wrote on 04.10.02 in <02100408071900.02266@boiler>:

> On Friday 04 October 2002 08:06, Alan Cox wrote:

> > IMHO the Lindent script is broken. It should also specify a line length
> > of something like 256 so it doesnt go mashing lines.
>
> Well, currently the Lindent script specifies a line length of 80 characters.
> Should this be changed?
>
> indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl "$@"
>                          ^^^^
>
> The CodingStyle document doesn't seem to specifically mention line length,
> but does imply in a couple of places that code should fit nicely on a
> 80-column, 24/25-line terminal.

I'd say that keeping the lines at 80 max is a real requirement, but  
Lindent is a bad way to implement it, as it just isn't intelligent enough  
to find good breaks in overly long lines.

MfG Kai
