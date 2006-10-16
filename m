Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWJPE6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWJPE6G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 00:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWJPE6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 00:58:06 -0400
Received: from hera.kernel.org ([140.211.167.34]:44246 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750756AbWJPE6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 00:58:03 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC][PATCH 2/2] ACPI: handle timer ticks proactively
Date: Mon, 16 Oct 2006 00:59:59 -0400
User-Agent: KMail/1.8.2
Cc: ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@linux.intel.com>
References: <1156884713.1781.122.camel@localhost.localdomain>
In-Reply-To: <1156884713.1781.122.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QHxMFESzlD49Erb"
Message-Id: <200610160100.00954.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_QHxMFESzlD49Erb
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I ran bltk this patch vs 2.6.18.1 on a Dell i6400 Core Duo laptop.
Initial result (1 measurement of each kernel) is that
battery life is unchanged, but response time improves with the new patch.

Summary files attached.

thanks,
-Len

--Boundary-00=_QHxMFESzlD49Erb
Content-Type: text/plain;
  charset="utf-8";
  name="Report.2.6.8.1-amb2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Report.2.6.8.1-amb2"


                             Workload
                        Workload : Open Office (office) 1.0.4

                              System
                    Manufacturer : Dell Inc.
                    Product Name : MM061
                  System Release : SUSE LINUX 10.1 (i586)
                  Kernel Release : 2.6.18.1-dirty

                                CPU
                             CPU : 0
                       CPU Model : Genuine Intel(R) CPU T2500 @ 2.00GHz
                      Cache Size : 2048 KB
                     Num Logical : 2
                        Governor : ondemand
                           Timer : 0.00
                      Interrupts : 8.93
                            Load : 1.58%
                    Max Frequecy : 2000000
                   Min Frequency : 1000000
               Average Frequency : 1017733
             Bus Master Activity : 0.00
                              C1 : 31.88
                              C2 : 32.65
                              C3 : 260.95
                              P0 : 1.69
                              P1 : 0.09
                              P2 : 0.05
                              P3 : 98.16

                                CPU
                             CPU : 1
                       CPU Model : Genuine Intel(R) CPU T2500 @ 2.00GHz
                      Cache Size : 2048 KB
                     Num Logical : 2
                        Governor : ondemand
                           Timer : 249.98
                      Interrupts : 2.82
                            Load : 1.92%
                    Max Frequecy : 2000000
                   Min Frequency : 1000000
               Average Frequency : 1017733
             Bus Master Activity : 0.00
                              C1 : 4.19
                              C2 : 5.03
                              C3 : 287.82
                              P0 : 1.69
                              P1 : 0.09
                              P2 : 0.05
                              P3 : 98.16

                              Memory
                     Memory Size : 2064260 kB
                       Swap Size : 2104472 kB
                      Max Memory : 664196 kB
                        Max Swap : 0 kB

                              Display
                    Grafic Model : Intel Corporation Mobile 945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
                    Display Size : 1280x800x16
                   Display State : on 100.00%, standby 0.00%, suspend 0.00%, off 0.00%

                                HD
                        HD Model : HTS721010G9SA00
                         HD Size : 100030 MBytes (100 GB)
                          HD RPM : -
                        HD Reads : 0.00 per sec
                       HD Writes : 2.77 per sec
                        HD State : active/idle 0.00%, standby 100.00%, sleeping 0.00%

                                BAT
                   Battery Model : DELLUD2646
                  Charging State : charged
                  Design Voltage : 11100 mV
                 Design Capacity : 53280 mWh (100.00%)
              Last Full Capacity : 48384 mWh (90.81%)
              Remaining Capacity : 53280 mWh (100.00%)
                  Start Capacity : 53280 mWh (100.00%)
                 Finish Capacity : 11 mWh (0.02%)
                      Drain Rate : 16.31 W (4.53 mWh per sec)
           Design Battery Rating : 196 min (03:16:02)

                              Rating
                  Battery Rating : 196 min (03:16:00)
                      Iterations : 16.33
                      Cycle Time : 720.00 sec
                       Work Time : 481.48 sec
                   Response Time : 8.28 sec
                           Score : 289.92

                              Source
                          Source : results.office.amb2a

                              Comment
                         Comment : -

                            Test Result
                          Result : Passed


--Boundary-00=_QHxMFESzlD49Erb
Content-Type: text/plain;
  charset="utf-8";
  name="Report.2.6.8.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Report.2.6.8.1"


                             Workload
                        Workload : Open Office (office) 1.0.4

                              System
                    Manufacturer : Dell Inc.
                    Product Name : MM061
                  System Release : SUSE LINUX 10.1 (i586)
                  Kernel Release : 2.6.18.1

                                CPU
                             CPU : 0
                       CPU Model : Genuine Intel(R) CPU T2500 @ 2.00GHz
                      Cache Size : 2048 KB
                     Num Logical : 2
                        Governor : ondemand
                           Timer : 0.00
                      Interrupts : 11.84
                            Load : 2.18%
                    Max Frequecy : 2000000
                   Min Frequency : 1000000
               Average Frequency : 1016988
             Bus Master Activity : 0.00
                              C1 : 0.00
                              C2 : 10.39
                              C3 : 565.52
                              P0 : 1.63
                              P1 : 0.09
                              P2 : 0.03
                              P3 : 98.25

                                CPU
                             CPU : 1
                       CPU Model : Genuine Intel(R) CPU T2500 @ 2.00GHz
                      Cache Size : 2048 KB
                     Num Logical : 2
                        Governor : ondemand
                           Timer : 249.98
                      Interrupts : 0.00
                            Load : 1.43%
                    Max Frequecy : 2000000
                   Min Frequency : 1000000
               Average Frequency : 1016988
             Bus Master Activity : 0.00
                              C1 : 0.00
                              C2 : 11.11
                              C3 : 323.20
                              P0 : 1.63
                              P1 : 0.09
                              P2 : 0.03
                              P3 : 98.25

                              Memory
                     Memory Size : 2064260 kB
                       Swap Size : 2104472 kB
                      Max Memory : 658288 kB
                        Max Swap : 0 kB

                              Display
                    Grafic Model : Intel Corporation Mobile 945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
                    Display Size : 1280x800x16
                   Display State : on 100.00%, standby 0.00%, suspend 0.00%, off 0.00%

                                HD
                        HD Model : HTS721010G9SA00
                         HD Size : 100030 MBytes (100 GB)
                          HD RPM : -
                        HD Reads : 0.07 per sec
                       HD Writes : 2.76 per sec
                        HD State : active/idle 0.00%, standby 100.00%, sleeping 0.00%

                                BAT
                   Battery Model : DELLUD2646
                  Charging State : charged
                  Design Voltage : 11100 mV
                 Design Capacity : 53280 mWh (100.00%)
              Last Full Capacity : 48362 mWh (90.77%)
              Remaining Capacity : 53280 mWh (100.00%)
                  Start Capacity : 53280 mWh (100.00%)
                 Finish Capacity : 55 mWh (0.10%)
                      Drain Rate : 16.29 W (4.53 mWh per sec)
           Design Battery Rating : 196 min (03:16:12)

                              Rating
                  Battery Rating : 196 min (03:16:00)
                      Iterations : 16.33
                      Cycle Time : 720.00 sec
                       Work Time : 482.11 sec
                   Response Time : 8.87 sec
                           Score : 270.59

                              Source
                          Source : results.office.ref

                              Comment
                         Comment : -

                            Test Result
                          Result : Passed


--Boundary-00=_QHxMFESzlD49Erb--
