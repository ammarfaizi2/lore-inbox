Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSKIVv6>; Sat, 9 Nov 2002 16:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbSKIVv6>; Sat, 9 Nov 2002 16:51:58 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:64697 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S262730AbSKIVv5>; Sat, 9 Nov 2002 16:51:57 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Clean up scsi documentation
Date: Sat, 9 Nov 2002 23:01:23 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211092301.23115@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

currently the documentation for scsi is not completely located where it should 
IMHO be: in Documentation/

There are a few files in Documentation and much more files in drivers/scsi/ . 
I think this should be fixed. Any thougts?

My way would be:

1) create a directory Documentation/scsi/
2) move everything to this location
3) rename some of the docs (currently the names look like "README.drivername" 
but "drivername.txt" is more common in Documentation/*)
4) fix up the references
5) add a 00-INDEX file to Documentation/scsi

Linus, Marcello: would you apply such a patch? In which form would you like to 
get them? One big patch? One patch that moves the files and one to fix the 
references? A patch to move the files and a patch for the references?

I found also some minor bugs in some docs: trailing newlines, strange 
characters etc. This will be an extra patch.

Eike
