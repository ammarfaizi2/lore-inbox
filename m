Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbRDEB0d>; Wed, 4 Apr 2001 21:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132508AbRDEB0R>; Wed, 4 Apr 2001 21:26:17 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:20453 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S132482AbRDEB0B>;
	Wed, 4 Apr 2001 21:26:01 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200104050125.SAA21252@csl.Stanford.EDU>
Subject: [QUESTION] MOD_INC/MOD_DEC: useful to check for correct usage?
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Apr 2001 18:25:08 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in the old days you couldn't call a sleeping function in a module
before doing a MOD_INC or after doing a MOD_DEC.  Then some safety nets
were added that made these obsolete (in some number of places).  I was
told that people had decided to potentially get rid of all safety
nets.  Is this true?  Is it worthwhile to have a checker for these two
rules?
