Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263561AbREYFfW>; Fri, 25 May 2001 01:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263541AbREYFfM>; Fri, 25 May 2001 01:35:12 -0400
Received: from Xenon.Stanford.EDU ([171.64.66.201]:43495 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263572AbREYFfE>; Fri, 25 May 2001 01:35:04 -0400
Date: Thu, 24 May 2001 22:34:56 -0700
From: Andy Chou <acc@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: mc@CS.Stanford.EDU, su.class.cs99q@nntp.stanford.edu
Subject: [CHECKER] Web interface to database
Message-ID: <20010524223456.A2506@Xenon.Stanford.EDU>
Reply-To: acc@CS.Stanford.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've made the database of errors found as part of the MC project
online.  Some of the cool features are:

- Over 3500 errors (not necessarily unique across versions)
- Results for 12 checkers, across 18 Linux versions from 1.0 to 2.4.4
- Keyword search on the file, function, or cause of an error
- Default sorting of results by severity of bug/ease of diagnosis
- Sorting results by file, function, and other fields
- Filter out error reports that also exist in older versions
- Links to annotated source code for each error

The URL:

http://hands.stanford.edu/linux


Some disclaimers:

1) We're improving the site and updating the database constantly, so it
might not always be accessible, or it might show incomplete data at times.

2) We're looking for feedback on how to improve things.  Please send
suggestions to mc@cs.stanford.edu.  Also, please email us if you fix any
of the errors, or can show that they are not errors.

3) Not all checker results are available for all versions.  We load the
database asynchronously with the bug reports sent to LKML.

4) All queries are logged.  We are doing this so we can analyze what
errors people are interested in, and also as a precaution in case there
are any attacks.

5) Queries that return a large number of results will take a while to run.  
Please be patient, or restrict the scope of queries.

6) See the FAQ link for answers to some other questions.  The
documentation, including the description of the checkers, is under
construction.


Enjoy,
-Andy Chou

